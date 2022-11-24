import * as React from "react";
import { Button, Container, Form } from "react-bootstrap";

const Login = () => {
  return (
    <Container className="mt-3" style={{maxWidth: '500px'}}>
      <h3 className="text-center">Login</h3>
      <Form action="/login" method="post">
        <Form.Group className="mb-3" controlId="formBasicEmail">
          <Form.Label>Email address</Form.Label>
          <Form.Control type="email" name="email" placeholder="Enter email" />
        </Form.Group>

        <Form.Group className="mb-3" controlId="formBasicPassword">
          <Form.Label>Password</Form.Label>
          <Form.Control type="password" name="password" placeholder="Password" />
        </Form.Group>
        <Button variant="primary" type="submit" className="w-100">
          Login
        </Button>
      </Form>
    </Container>
  )
}

export default Login;
