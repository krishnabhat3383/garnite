import React, { useEffect, useState } from "react";
import { isNil, isEmpty, either } from "ramda";

import Container from "components/Container";
import Table from "components/Tasks/Table";
import taskApi from "apis/tasks";
import PageLoader from "components/PageLoader";

const Dashboard = ({ history }) => {
  const [tasks, setTasks] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchTasks = async () => {
    try {
      const response = await taskApi.list();
      setTasks(response.data.tasks);
      setLoading(false);
    } catch (error) {
      // logger.error(error);
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchTasks();
  }, []);

  if (loading) {
    return (
      <div className="w-screen h-screen">
        <PageLoader />
      </div>
    );
  }

  if (either(isNil, isEmpty)(tasks)) {
    return (
      <Container>
        <h1 className="text-xl leading-5 text-center">
          You have no Tasks Assigned
        </h1>
      </Container>
    );
  }

  return (
    <Container>
      <Table data={tasks} />
    </Container>
  );
};

export default Dashboard;
