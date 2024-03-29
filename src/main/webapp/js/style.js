function add_to_cart(pid, pname, pprice) {

    let cart = localStorage.getItem("cart");
    if (cart == null) {

        //no cart yet
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: pprice}
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        showToast("Item is added to cart.");
    } else {

        //cart is already present
        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId == pid)
        if (oldProduct) {

            //we have to increase the quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;
            pcart.map((item) => {

                if (item.productId == oldProduct.productId) {
                    item.productQuantity = oldProduct.productQuantity;
                }
            })

            localStorage.setItem("cart", JSON.stringify(pcart));
            showToast(oldProduct.productName + " quantity is increased. Quantity = " + oldProduct.productQuantity);


        } else {

            //we have to add the product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: pprice}
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            showToast("Item is added to cart.");

        }
    }

    updateCart();
}

//update cart
function updateCart() {

    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    if (cart == null || cart.length == 0) {

        $(".cart-items").html(" ( 0 ) ");
        $(".cart-body").html("<h3>Cart does not have any items.</h3>");
        $(".checkout-btn").addClass('disabled');
        $(".place-order").addClass('disabled');
    } else {

        //there is something in cart
        $(".cart-items").html(` ( ${cart.length} ) `);
        let table = `
            <table class="table">
            <thead class="thead-light">
                <tr>
                <th>Item Name</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Action</th>
                </tr>           
                      
            </thead>
                                
        `;

        let totalPrice = 0;
        cart.map((item) => {

            table += `
                      <tr>
                            <td> ${item.productName} </td>
                            <td>
                            <button class="btn btn-sm btn-info" onclick="decrementQuantity(${item.productId})">-</button>
                            ${item.productQuantity}
                            <button class="btn btn-sm btn-info" onclick="incrementQuantity(${item.productId})">+</button>
                            </td>
                            <td> ${item.productQuantity * item.productPrice} </td>
                            <td> <button onclick="deleteItemFromCart( ${item.productId} )" class="btn btn-danger btn-sm">Remove</button></td>                                                                 
                      </tr>
            `

            totalPrice += item.productPrice * item.productQuantity;
        })

        table = table + `

                       <tr>
                            <td colspan="5" class="text-end fw-bold"> Total Price : ${totalPrice} </td>
                       </tr>
                </table>`
        $(".cart-body").html(table);
        $(".checkout-btn").removeClass('disabled');
        $(".place-order").removeClass('disabled');
    }
}

//delete item
function deleteItemFromCart(pid) {
    let cart = JSON.parse(localStorage.getItem("cart"));

    let newcart = cart.filter((item) => item.productId != pid);

    localStorage.setItem("cart", JSON.stringify(newcart));

    updateCart();

    showToast("Item is removed from cart.");


}

//increment Quantity
function incrementQuantity(pid) {
    let cart = JSON.parse(localStorage.getItem("cart"));
    let product = cart.find((item) => item.productId === pid);
    if (product) {
        product.productQuantity += 1;
        localStorage.setItem("cart", JSON.stringify(cart));
        updateCart();
    }
}

//decrement Quantity
function decrementQuantity(pid) {
    let cart = JSON.parse(localStorage.getItem("cart"));
    let product = cart.find((item) => item.productId === pid);
    if (product) {
        product.productQuantity -= 1;
        if (product.productQuantity === 0) {
            // Remove item if quantity is zero
            deleteItemFromCart(pid);
        } else {
            localStorage.setItem("cart", JSON.stringify(cart));
            updateCart();
        }
    }
}

$(document).ready(function () {
    updateCart();
})

//toast message
function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
        $("#toast").removeClass("display");
    }, 2000)
}

function goToCheckout() {

    window.location = "checkout.jsp"
}