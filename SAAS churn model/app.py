# ================================
# SaaS Churn Prediction (Streamlit)
# ================================

import streamlit as st
import pandas as pd
import numpy as np
import pickle
import shap
import matplotlib.pyplot as plt

st.set_page_config(page_title="SaaS Churn Prediction", layout="wide")

# Load model
with open("SAAS churn model/xgb_model.pkl", "rb") as f:
    model = pickle.load(f)

# Load SHAP explainer
with open("shap_explainer.pkl", "rb") as f:
    explainer = pickle.load(f)

# Load feature columns
with open("feature_columns.pkl", "rb") as f:
    feature_cols = pickle.load(f)

st.title("📉 SaaS Customer Churn Prediction with XAI")

st.sidebar.header("Subscription Inputs")

days_since_last_usage = st.sidebar.slider("Days Since Last Usage", 0, 180, 14)
usage_ratio_30_90 = st.sidebar.slider("Usage Ratio (30d / 90d)", 0.0, 1.0, 0.6)
subscription_age_days = st.sidebar.number_input("Subscription Age (days)", 1, 1500, 90)
avg_first_response_time = st.sidebar.slider("Avg First Response Time (mins)", 1, 300, 45)
escalation_rate = st.sidebar.slider("Escalation Rate", 0.0, 1.0, 0.1)
avg_satisfaction_score = st.sidebar.slider("Avg Satisfaction Score", 1.0, 5.0, 3.5)

input_data = pd.DataFrame(np.zeros((1, len(feature_cols))), columns=feature_cols)

input_data['days_since_last_usage'] = days_since_last_usage
input_data['usage_ratio_30_90'] = usage_ratio_30_90
input_data['subscription_age_days'] = subscription_age_days
input_data['avg_first_response_time'] = avg_first_response_time
input_data['escalation_rate'] = escalation_rate
input_data['avg_satisfaction_score'] = avg_satisfaction_score

if st.button("Predict Churn Risk"):
    churn_prob = model.predict_proba(input_data)[0][1]

    st.metric("Churn Probability", f"{churn_prob:.2%}")

    if churn_prob >= 0.30:
        st.error("🚨 High Churn Risk — Retention Action Recommended")
    else:
        st.success("✅ Low Churn Risk")

    st.subheader("🔍 Explanation (SHAP)")
    shap_values = explainer.shap_values(input_data)

    fig, ax = plt.subplots()
    shap.waterfall_plot(
        shap.Explanation(
            values=shap_values[0],
            base_values=explainer.expected_value,
            data=input_data.iloc[0],
            feature_names=input_data.columns
        ),
        max_display=10
    )

    st.pyplot(fig)
