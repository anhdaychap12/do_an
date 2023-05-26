<!-- #include file="connect.asp" -->
<!--#include file="layout/header.asp"-->
<body>
    <div class="main">
        <div class="checkout">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>Checkout</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col l-8 m-12 c-12">
                        <div class="checkout-info">
                            <form method="post">
                                <h4>Checkout info</h4>
                                <div class="row">
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Name"><p class="add-description">Full name:</p></label>
                                            <input type="text" id="Name" name="Name" placeholder="Lê Đức Chó">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Username"><p class="add-description">Username:</p></label>
                                            <input type="text" id="Username" name="Username" placeholder="Username">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Email"><p class="add-description">Email:</p></label>
                                            <input type="email" id="Email" name="Email" placeholder="cho123@gmail.com">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Phone"><p class="add-description">Phone:</p></label>
                                            <input type="text" id="Phone" name="Phone" placeholder="0965228545">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Address"><p class="add-description">Address:</p></label>
                                            <input type="text" id="Address" name="Address" placeholder="69 Tam Trinh">
                                         </div>
                                    </div>
                                </div>
                                <a href="#" class="checkout-btn">Submit</a>
                           </form>
                        </div>
                    </div>
                    <div class="col l-4 m-12 c-12">
                        <div class="checkout-cart-info">
                            <div class="checkout-cart-title">
                                <h4>Your cart</h4>
                                <span>1</span>
                            </div>
                            <div class="checkout-cart-content">
                                <div class="checkout-cart-item">
                                    <div class="checkout-cart-item-title">
                                        <h4>Product 1</h4>
                                        <p>Description</p>
                                    </div>
                                    <h4>Price</h4>
                                </div>
                                <div class="checkout-cart-item">
                                    <div class="checkout-cart-item-title">
                                        <h4>Product 2</h4>
                                        <p>Description</p>
                                    </div>
                                    <h4>Price</h4>
                                </div>
                                <div class="checkout-cart-item">
                                    <div class="checkout-cart-item-title">
                                        <h4>Product 3</h4>
                                        <p>Description</p>
                                    </div>
                                    <h4>Price</h4>
                                </div>
                            </div>
                            <div class="checkout-cart-shipping">
                                <p>Normal/Express</p>
                                <h4>-$5</h4>
                            </div>
                            <div class="checkout-cart-total">
                                <h4>Total:</h4>
                                <h4>$400</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- #include file="layout/footer.asp" -->
    </div>
    <script src="main.js"></script>
</body>