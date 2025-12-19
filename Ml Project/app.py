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
movies = pickle.load(open(os.
