import React from "react";
import "antd/dist/antd.css";
import Layout from "antd/lib/layout/layout";
import { Button, Row, Typography } from "antd";

const { Title, Paragraph, Text, Link } = Typography;

function App() {
  const [oneIsLoading, setOneIsLoading] = React.useState(false);
  const [twoIsLoading, setTwoIsLoading] = React.useState(false);

  const onSpendClick = async () => {
    setOneIsLoading(true);
    //@ts-ignore
    await window.spend.postMessage("20");
    setOneIsLoading(false);
  };

  const onMintClick = async () => {
    setTwoIsLoading(true);
    //@ts-ignore
    await window.mint.postMessage("20");
    setTwoIsLoading(false);
  };

  return (
    <Layout
      style={{
        width: "100%",
        height: "100vh",
        alignContent: "center",
        alignItems: "center",
        display: "flex",
        justifyContent: "center",
        flexDirection: "column",
        padding: 20,
      }}
    >
      <Title>We are building a web app</Title>
      <Paragraph>
        Mini App is the future.In the process of internal desktop applications
        development, many different design specs and implementations would be
        involved, which might cause designers and developers difficulties and
        duplication and reduce the efficiency of development.
      </Paragraph>
      <div
        style={{
          alignContent: "center",
          alignItems: "center",
          display: "flex",
          justifyContent: "center",
          flexDirection: "column",
        }}
      >
        <Row style={{ margin: 10 }}>
          <Button type="primary" onClick={onSpendClick} loading={oneIsLoading}>
            Spend 20 tokens
          </Button>
        </Row>
        <Row style={{ margin: 10 }}>
          <Button type="primary" onClick={onMintClick} loading={twoIsLoading}>
            Mint 20 tokens
          </Button>
        </Row>
      </div>
    </Layout>
  );
}

export default App;
