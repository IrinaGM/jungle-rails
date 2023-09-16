describe('product details', () => {
    beforeEach(() => {
        // visit the homepage before each test
        cy.visit('/')
    })

    it("user can navigate to Giant Tea product details page", () => {
        cy.get('[alt="Giant Tea"]').click()
        cy.url().should('contain', '/products/1');
    });

})