st.sidebar.title("Customer Details")

with st.sidebar.expander("📊 Product Usage", expanded=True):
    days_since_last_usage = st.slider(
        "Days since last product usage",
        0, 180, 14,
        help="How many days have passed since the customer last used the product"
    )

    usage_ratio_30_90 = st.slider(
        "Recent activity vs past activity",
        0.0, 1.0, 0.6,
        help="Lower values indicate a decline in recent usage"
    )

with st.sidebar.expander("🧾 Subscription Info", expanded=True):
    subscription_age_days = st.number_input(
        "Customer lifetime (days)",
        1, 1500, 90,
        help="How long the customer has been subscribed"
    )

with st.sidebar.expander("🎧 Support Experience", expanded=True):
    avg_first_response_time = st.slider(
        "Average support response time (minutes)",
        1, 300, 45,
        help="Time taken by support team to respond initially"
    )

    escalation_rate = st.slider(
        "Issue escalation frequency",
        0.0, 1.0, 0.1,
        help="Higher values indicate frequent unresolved issues"
    )

    avg_satisfaction_score = st.slider(
        "Customer satisfaction score",
        1.0, 5.0, 3.5,
        help="Average customer satisfaction rating"
    )
