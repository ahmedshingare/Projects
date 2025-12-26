# ================================
# SaaS Churn Prediction (Streamlit)
# Business-Friendly UI
# ================================

import streamlit as st
import pandas as pd
import numpy as np
import pickle
import shap
import matplotlib.pyplot as plt

# -------------------------------
# Page Config
# -------------------------------
st.set_page_config(
    page_title="SaaS Customer Churn Risk",
    page_icon="📉",
    layout="wide"
)

# -------------------------------
# Load Artifacts
# -------------------------------
@st.cache_resource
def load_artifacts():
    with open("SAAS churn model/xgb_model.pkl", "rb") as f:
        model = pickle.load(f)

    with open("SAAS churn model/shap_explainer.pkl", "rb") as f:
        explainer = pickle.load(f)

    with open("SAAS churn model/feature_columns.pkl", "rb") as f:
        feature_cols = pickle.load(f)

    return model, explainer, feature_cols


model, explainer, feature_cols = load_artifacts()

# -------------------------------
# App Title
# -------------------------------
st.title("📉 SaaS Customer Churn Risk Dashboard")
st.markdown(
    """
    This tool helps **business teams** identify customers at risk of leaving  
    and understand **why**, so timely retention actions can be taken.
    """
)

# -------------------------------
# Sidebar Inputs (Business-Friendly)
# -------------------------------
st.sidebar.title("🧾 Customer Information")

with st.sidebar.expander("📊 Product Usage", expanded=True):
    days_since_last_usage = st.slider(
        "Days since last product usage",
        0, 180, 14,
        help="Number of days since the customer last used the product"
    )

    usage_ratio_30_90 = st.slider(
        "Recent activity compared to past activity",
        0.0, 1.0, 0.6,
        help="Lower values indicate a recent decline in usage"
    )

with st.sidebar.expander("📆 Subscription Details", expanded=True):
    subscription_age_days = st.number_input(
        "Customer lifetime (days)",
        min_value=1,
        max_value=1500,
        value=90,
        help="How long the customer has been subscribed"
    )

with st.sidebar.expander("🎧 Support Experience", expanded=True):
    avg_first_response_time = st.slider(
        "Average support response time (minutes)",
        1, 300, 45,
        help="Time taken by support team to respond initially"
    )

    escalation_rate = st.slider(
        "How often issues are escalated",
        0.0, 1.0, 0.1,
        help="Higher values mean more unresolved issues"
    )

    avg_satisfaction_score = st.slider(
        "Customer satisfaction score",
        1.0, 5.0, 3.5,
        help="Average customer satisfaction rating"
    )

# -------------------------------
# Prepare Model Input
# -------------------------------
input_data = pd.DataFrame(
    np.zeros((1, len(feature_cols))),
    columns=feature_cols
)

input_data["days_since_last_usage"] = days_since_last_usage
input_data["usage_ratio_30_90"] = usage_ratio_30_90
input_data["subscription_age_days"] = subscription_age_days
input_data["avg_first_response_time"] = avg_first_response_time
input_data["escalation_rate"] = escalation_rate
input_data["avg_satisfaction_score"] = avg_satisfaction_score

# -------------------------------
# Prediction Section
# -------------------------------
st.divider()
st.subheader("📌 Churn Risk Assessment")

if st.button("🔍 Analyze Churn Risk"):
    churn_prob = model.predict_proba(input_data)[0][1]

    # Risk Segmentation
    if churn_prob >= 0.50:
        risk_level = "HIGH"
        st.error("🚨 HIGH RISK OF CHURN")
        recommendation = "Immediate retention action required (personal outreach, offer, or support call)."
    elif churn_prob >= 0.30:
        risk_level = "MEDIUM"
        st.warning("⚠️ MEDIUM RISK OF CHURN")
        recommendation = "Monitor closely and consider proactive engagement."
    else:
        risk_level = "LOW"
        st.success("✅ LOW RISK OF CHURN")
        recommendation = "No immediate action required."

    # Metrics Display
    col1, col2, col3 = st.columns(3)
    col1.metric("Churn Probability", f"{churn_prob:.0%}")
    col2.metric("Risk Level", risk_level)
    col3.metric("Recommended Action", "See below")

    st.progress(min(churn_prob, 1.0))

    st.markdown(f"**Recommended Action:** {recommendation}")

    # -------------------------------
    # Explainability Section
    # -------------------------------
    st.divider()
    st.subheader("🔍 Why is this customer at risk?")
    st.caption("The chart below shows the main factors influencing this prediction.")

    try:
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

        st.markdown(
            """
            **How to read this chart:**
            - Factors pushing the customer **towards leaving** appear on the right  
            - Factors **reducing churn risk** appear on the left  
            - Longer bars indicate stronger impact
            """
        )

    except Exception:
        st.warning("Explanation temporarily unavailable.")

# -------------------------------
# Footer
# -------------------------------
st.divider()
st.caption(
    "Built using Machine Learning & Explainable AI to support data-driven retention decisions."
)
