import axios from "axios";

axios.defaults.baseURL = "/";

export const setAuthHeaders = (setLoading = () => null) => {
  axios.defaults.headers = {
    Accept: "application/json",
    "Content-Type": "application/json",
    "X-CSRF-TOKEN": document
      .querySelector('[name="csrf-token"]')
      .getAttribute("content")
  };
  const token = localStorage.getItem("authToken");
  const email = localStorage.getItem("authEmail");

  if (token && email) {
    axios.defaults.headers["X-AUTH-TOKEN"] = token;
    axios.defaults.headers["X-AUTH-EMAIL"] = email;
  }
  setLoading(false);
};
