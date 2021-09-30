import React, { useState } from "react";
import Container from "components/Container";
import TaskForm from "components/Form/TaskForm";
import taskApi from "apis/tasks";

const CreateTask = ({ history }) => {
  const [title, setTitle] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async event => {
    event.preventDefault();
    try {
      setLoading(true);
      await taskApi.createTask({ task: { title } });
      setLoading(false);
      history.push("/dashboard");
    } catch {
      logger.error(error);
      setLoading(false);
    }
  };

  return (
    <Container>
      <TaskForm
        setTitle={setTitle}
        loading={loading}
        handleSubmit={handleSubmit}
      />
    </Container>
  );
};

export default CreateTask;
