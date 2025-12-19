import pickle
import streamlit as st
import requests
import os

TMDB_API_KEY = "8265bd1679663a7ea12ac168da84d2e8"

# ---------- Fetch movie details ----------
def fetch_movie_details(movie_id):
    url = f"https://api.themoviedb.org/3/movie/{movie_id}?api_key={TMDB_API_KEY}&language=en-US"
    data = requests.get(url).json()

    poster_path = data.get("poster_path")
    overview = data.get("overview", "No overview available.")
    rating = data.get("vote_average", "N/A")

    poster_url = (
        "https://image.tmdb.org/t/p/w500/" + poster_path
        if poster_path
        else "https://via.placeholder.com/500x750?text=No+Poster"
    )

    return poster_url, overview, rating


# ---------- Recommendation logic ----------
def recommend(movie, n):
    index = movies[movies["title"] == movie].index[0]
    distances = sorted(
        list(enumerate(similarity[index])),
        reverse=True,
        key=lambda x: x[1]
    )

    results = []
    for i in distances[1:n+1]:
        movie_id = movies.iloc[i[0]]["movie_id"]
        title = movies.iloc[i[0]]["title"]
        poster, overview, rating = fetch_movie_details(movie_id)
        results.append((title, poster, overview, rating))

    return results


# ---------- Page Config ----------
st.set_page_config(page_title="Movie Recommender", layout="wide")

# ---------- Load Data ----------
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
movies = pickle.load(open(os.path.join(BASE_DIR, "movie_list.pkl"), "rb"))
similarity = pickle.load(open(os.path.join(BASE_DIR, "similarity.pkl"), "rb"))

# ---------- Sidebar ----------
st.sidebar.title("🎥 Movie Recommender")
st.sidebar.write("Get movie recommendations using ML similarity")

movie_list = movies["title"].values

selected_movie = st.sidebar.selectbox(
    "🎬 Select a movie",
    movie_list
)

num_recommendations = st.sidebar.slider(
    "🎯 Number of recommendations",
    3, 10, 5
)

show_btn = st.sidebar.button("🔍 Show Recommendation")

# ---------- Main Page ----------
st.title("🎬 Recommended Movies")

if show_btn:
    with st.spinner("Finding similar movies for you... 🎬"):
        recommendations = recommend(selected_movie, num_recommendations)

    cols = st.columns(num_recommendations)
    for col, (title, poster, overview, rating) in zip(cols, recommendations):
        with col:
            st.image(poster)
            st.subheader(title)
            st.markdown(f"⭐ **Rating:** {rating}/10")

            with st.expander("📖 Overview"):
                st.write(overview)
else:
    st.info("👈 Select a movie and click **Show Recommendation** from the sidebar")
