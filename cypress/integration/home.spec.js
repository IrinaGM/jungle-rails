describe('home page', () => {
    beforeEach(() => {
        // visit the homepage before each test
        cy.visit('/')
    })

    it("Products are visible on the page", () => {
        cy.get(".products article").should("be.visible");
    });

    it("There are 2 products on the page", () => {
        cy.get(".products article").should("have.length", 2);
    });
})