import axios from "axios";

const list = () => axios.get("/tasks");

const createTask = payload => axios.post("/tasks/", payload);

const show = slug => axios.get(`tasks/${slug}`);

const taskApi = {
  list,
  show,
  createTask
};

export default taskApi;
