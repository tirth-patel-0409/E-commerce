<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- modal for checkout --%>
<div class="modal fade" id="cart" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Your Cart</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <div class="cart-body">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary checkout-btn" onclick="goToCheckout()">Checkout</button>
            </div>
        </div>
    </div>
</div>

<div id="toast">This is our custom toast.</div>
