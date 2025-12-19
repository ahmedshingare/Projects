import pickle
import streamlit as st
import requests
import os

# ---------- Fetch poster ----------
def fetch_poster(movie_id):
    url = f"https://api.themoviedb.org/3/movie/{movie_id}?api_key=8265bd1679663a7ea12ac168da84d2e8&language=en-US"
    data = requests.get(url).json()
    poster_path = data.get("poster_path")

    if poster_path:
        return "https://image.tmdb.org/t/p/w500/" + poster_path
    else:
        return "https://via.placeholder.com/500x750?text=No+Poster"

# ---------- Recommendation logic ----------
def recommend(movie, n):
    index = movies[movies["title"] == movie].index[0]
    distances = sorted(
        list(enumerate(similarity[index])),
        reverse=True,
        key=lambda x: x[1]
    )

    names, posters = [], []
    for i in distances[1:n+1]:
        movie_id = movies.iloc[i[0]]["movie_id"]
        names.append(movies.iloc[i[0]]["title"])
        posters.append(fetch_poster(movie_id))

    return names, posters


# ---------- Page Config ----------
st.set_page_config(page_title="Movie Recommender", layout="wide")

# ---------- Sidebar ----------
st.sidebar.title("🎥 Movie Recommender")
st.sidebar.write("Get movie recommendations using ML similarity")

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
movies = pickle.load(open(os.path.join(BASE_DIR, "movie_list.pkl"), "rb"))
similarity = pickle.load(open(os.path.join(BASE_DIR, "similarity.pkl"), "rb"))

movie_list = movies["title"].values

selected_movie = st.sidebar.selectbox(
    "🎬 Select a movie",
    movie_list
)

num_recommendations = st.sidebar.slider(
    "🎯 Number of recommendations",
    min_value=3,
    max_value=10,
    value=5
)

show_btn = st.sidebar.button("🔍 Show Recommendation")

# ---------- Main Page ----------
st.title("🎬 Recommended Movies")

if show_btn:
    with st.spinner("Finding similar movies for you... 🎬"):
        recommended_movie_names, recommended_movie_posters = recommend(
            selected_movie, num_recommendations
        )

    cols = st.columns(num_recommendations)
    for col, name, poster in zip(cols, recommended_movie_names, recommended_movie_posters):
        with col:
            st.image(poster)
            st.caption(name)
else:
    st.info("👈 Select a movie and click **Show Recommendation** from the sidebar")
