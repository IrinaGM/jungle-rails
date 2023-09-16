describe('add to cart', () => {
    beforeEach(() => {
        // visit the homepage before each test
        cy.visit('/')
    })

    it("cart is increased by 1 when clicking on 'Add'", () => {
        cy.get(".products article").should("be.visible");
        cy.get('form[action="/cart/add_item?product_id=2"]').submit();
        cy.get('a.nav-link[href="/cart"]').should('contain', 'My Cart (1)');
    });

})