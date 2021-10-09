import axios from "axios";

const list = () => axios.get("/tasks");

const createTask = payload => axios.post("/tasks/", payload);

const show = slug => axios.get(`tasks/${slug}`);

const update = ({ slug, payload }) => axios.put(`/tasks/${slug}`, payload);

const taskApi = {
  list,
  show,
  createTask,
  update
};

export default taskApi;
