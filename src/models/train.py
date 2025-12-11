import pandas as pd
import mlflow
import mlflow.sklearn
from mlflow.models.signature import infer_signature
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, recall_score
import time
import json
import joblib
import os

def train_model(train_df: pd.DataFrame, test_df: pd.DataFrame, target: str, preprocessors: dict):

   
    X_train = train_df.drop(columns=[target])
    y_train = train_df[target]
    
    X_test = test_df.drop(columns=[target])
    y_test = test_df[target]

    params = {
        "n_estimators": 100,
        "max_depth": None,
        "random_state": 42
    }

    model = RandomForestClassifier(**params)

    with mlflow.start_run(nested=True) as run:
        print(f"--- Training Model (Run ID: {run.info.run_id}) ---")

        # Train
        t0 = time.time()
        model.fit(X_train, y_train)
        train_time = time.time() - t0

        # Evaluate
        y_pred = model.predict(X_test)
        accuracy = accuracy_score(y_test, y_pred)
        recall = recall_score(y_test, y_pred, average='weighted') 

       
        mlflow.log_params(params)
        mlflow.log_metric('training_time', train_time)
        mlflow.log_metric('accuracy', accuracy)
        mlflow.log_metric('recall', recall)

        local_artifact_path = "artifacts"
        os.makedirs(local_artifact_path, exist_ok=True)
        
        joblib.dump(preprocessors, os.path.join(local_artifact_path, "preprocessor.pkl"))
        
        meta_data = {
            "feature_columns": list(X_train.columns),
            "target": target
        }
        with open(os.path.join(local_artifact_path, "metadata.json"), "w") as f:
            json.dump(meta_data, f)
            
        mlflow.log_artifacts(local_artifact_path, artifact_path="pipeline_assets")

        signature = infer_signature(X_train, model.predict(X_train))
        
        mlflow.sklearn.log_model(
            sk_model=model, 
            artifact_path="model",
            signature=signature,
            input_example=X_train.iloc[:5]
        )

        print(f"Model trained. Accuracy: {accuracy:.4f}, Recall: {recall:.4f}")
        print("Model and artifacts saved to MLflow.")