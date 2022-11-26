import * as React from "react";
import { Button, Col, Container, Row, Table } from "react-bootstrap";

const ActionButton = ({ transaction }) => {
  if (transaction.processed) return

  switch (transaction.type){
    case 'AuthorizeTransaction':
      return (<>
        <a href={`transactions/reversal_transaction/${transaction.id}`} data-turbo-method="post">Reverse</a>
        <a href={`transactions/charge_transaction/${transaction.id}`} data-turbo-method="post" className="ms-3">Charge</a>
      </>)
    case 'ChargeTransaction':
      return <a href={`transactions/refund_transaction/${transaction.id}`} data-turbo-method="post">Refund</a>
  }

}

const Transactions = ({ transactions }) => {
  return (
    <Container fluid className="mt-3">
      <Row className="justify-content-end">
        <Col xs="auto">
          <Button href="transactions/new" className="ms-auto">Initiate Transaction</Button>
        </Col>
      </Row>

      <h3 className="text-center">All Transactions</h3>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>Transaction Id</th>
            <th>Amount</th>
            <th>Type</th>
            <th>Status</th>
            <th>Customer Details</th>
            <th>Datetime</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {transactions.map((transaction) => (
            <tr>
              <td>{transaction.id}</td>
              <td>{transaction.amount}</td>
              <td>{transaction.type}</td>
              <td>{transaction.status}</td>
              <td>{transaction.customer_email} | {transaction.customer_phone}</td>
              <td>{transaction.created_at}</td>
              <td><ActionButton transaction={transaction}/></td>
            </tr>
          ))}
        </tbody>
      </Table>
    </Container>
  )
}

export default Transactions;
