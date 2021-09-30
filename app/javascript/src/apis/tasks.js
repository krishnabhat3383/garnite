import axios from "axios";

const list = () => axios.get("/tasks");

const createTask = payload => axios.post("/tasks/", payload);

const taskApi = {
  list,
  createTask
};

export default taskApi;
