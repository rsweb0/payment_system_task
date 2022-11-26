import * as React from "react";
import { Button, Container, Form } from "react-bootstrap";
import PhoneInput from 'react-phone-number-input'
import "react-phone-number-input/style.css";

const NewTransaction = () => {
  const [customerPhone, setCustomerPhone] = React.useState('')

  return (
    <Container className="mt-3" style={{maxWidth: '500px'}}>
      <h3 className="text-center">Initiate Transaction</h3>
      <Form action="/transactions" method="post">
        <Form.Group className="mb-3" >
          <Form.Label>Amount</Form.Label>
          <Form.Control type="number" name="transaction[amount]" placeholder="Enter Amount" required/>
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Label>Customer Email</Form.Label>
          <Form.Control type="email" name="transaction[customer_email]" placeholder="Enter Customer Email" required/>
        </Form.Group>

        <Form.Group className="mb-3">
          <Form.Control type="hidden" name="transaction[customer_phone]" value={customerPhone}/>
          <PhoneInput
            placeholder="Enter Customer phone"
            value={customerPhone}
            onChange={setCustomerPhone}
            required
          />
        </Form.Group>

        <Button variant="primary" type="submit" className="w-100">
          Initiate Transaction
        </Button>
      </Form>
    </Container>
  )
}

export default NewTransaction;
