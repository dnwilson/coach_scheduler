import axios from "axios";

const http = axios.create({
  baseURL: "http://localhost:3000/api/v1",
  headers: {
    "Content-type": "application/json",
    "X-TimeZone": Intl.DateTimeFormat().resolvedOptions().timeZone
  }
});

const post = (path, data) => {
  return http.post(path, data)
}

const get = (path) => {
  return http.get(path)
}

export { get, post };
