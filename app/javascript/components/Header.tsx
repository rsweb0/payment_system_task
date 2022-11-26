import * as React from "react"
import { Container, Nav, Navbar } from "react-bootstrap"

const Header = ({ currentMerchant }) => {
  return (
    <Navbar bg="dark" variant="dark" expand="md">
      <Container>
        <Navbar.Brand href="/">Payment System</Navbar.Brand>
        <Navbar.Toggle />
        <Navbar.Collapse role="navigation" className="justify-content-end">
          <Nav className="ms-auto">
            {currentMerchant ? (
              <Navbar.Text>
                Signed in as: <a href="/logout" data-turbo-method="delete">{currentMerchant.name}</a>
              </Navbar.Text>
            ) : (
              <>
                <Nav.Link href="/login">Login</Nav.Link>
              </>
            )}
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
}

export default Header;
