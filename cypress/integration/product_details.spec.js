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

  it("Can visit an individual product", () => {
    // Assuming each product has a link to its individual page
    cy.get(".products article").first().find("a").click();
    cy.url().should("include", "/products/");
    cy.get(".product-detail").should("be.visible");
  });

})
