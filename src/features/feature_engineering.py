import pandas as pd
import numpy as np
from sklearn.preprocessing import OrdinalEncoder,OneHotEncoder

def feature_engineering(df: pd.DataFrame, encoders=None, fit=True):
    
    df = df.copy()

    work_interfere_order = ['Never', 'Rarely', 'Sometimes', 'Often', 'Not Applicable']
    no_employees_order = ['1-5', '6-25', '26-100', '100-500', '500-1000', 'More than 1000']
    leave_order = ['Very easy', 'Somewhat easy', "Don't know", 'Somewhat difficult', 'Very difficult']
    
    ordinal_cols = ['work_interfere', 'no_employees', 'leave']
    onehot_cols = ['Country', 'Gender', 'self_employed', 'family_history', 'remote_work', 
                   'tech_company', 'benefits', 'care_options', 'wellness_program',
                   'seek_help', 'anonymity', 'mental_health_consequence',
                   'phys_health_consequence', 'coworkers', 'supervisor',
                   'mental_health_interview', 'phys_health_interview',
                   'mental_vs_physical', 'obs_consequence']
    

    ordinal_cols = [col for col in ordinal_cols if col in df.columns]
    onehot_cols = [col for col in onehot_cols if col in df.columns]
    
    # 1. Ordinal Encoding
    if fit:
        ordinal_encoder = OrdinalEncoder(
            categories=[work_interfere_order, no_employees_order, leave_order],
            handle_unknown='use_encoded_value',
            unknown_value=-1
        )
        if ordinal_cols:
            df[ordinal_cols] = ordinal_encoder.fit_transform(df[ordinal_cols])
            print(f"Ordinal encoding fitted for: {ordinal_cols}")
    else:
        ordinal_encoder = encoders['ordinal_encoder']
        if ordinal_cols:
            df[ordinal_cols] = ordinal_encoder.transform(df[ordinal_cols])
            print(f"Ordinal encoding applied for: {ordinal_cols}")
    
    # 2. OneHot Encoding
    if fit:
        onehot_encoder = OneHotEncoder(sparse_output=False, handle_unknown='ignore', drop='first')
        if onehot_cols:
            df_onehot = onehot_encoder.fit_transform(df[onehot_cols])
            onehot_feature_names = onehot_encoder.get_feature_names_out(onehot_cols)
            
            df = df.drop(columns=onehot_cols)
            for i, col_name in enumerate(onehot_feature_names):
                df[col_name] = df_onehot[:, i]
            
            print(f"OneHot encoding fitted for {len(onehot_cols)} columns")
    else:
        onehot_encoder = encoders['onehot_encoder']
        if onehot_cols:
            df_onehot = onehot_encoder.transform(df[onehot_cols])
            onehot_feature_names = onehot_encoder.get_feature_names_out(onehot_cols)
            
            df = df.drop(columns=onehot_cols)
            for i, col_name in enumerate(onehot_feature_names):
                df[col_name] = df_onehot[:, i]
            
            print(f"OneHot encoding applied for {len(onehot_cols)} columns")

    if fit:
        new_encoders = {
            'ordinal_encoder': ordinal_encoder,
            'onehot_encoder': onehot_encoder,
            'ordinal_cols': ordinal_cols,
            'onehot_cols': onehot_cols
        }
        return df, new_encoders
    else:
        return df, None