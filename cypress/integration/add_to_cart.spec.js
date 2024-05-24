describe('visit jungle page', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('http://localhost:3000/')
  })


  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Cart count increases by one when 'Add to Cart' is clicked", () => {
    // Click the 'Add to Cart' button for the first product
    cy.get(".products article").first().find("button").contains("Add").click(({ force: true }))

    // Navigate to the cart page
    cy.visit('http://localhost:3000/cart')

    // Verify that the cart contains one product
    cy.get(".cart-show .items tbody tr").should("have.length", 1)
  
    })
  })