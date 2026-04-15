package com.neospark.neohub.utils;


public class EmailTemplate {

    private static String baseTemplate(String content) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8"/>
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; background: #f5f5f5; margin: 0; padding: 0; }
                    .wrap { max-width: 580px; margin: 40px auto; background: #ffffff; border: 1px solid #e0e0e0; border-radius: 6px; overflow: hidden; }
                    .header { padding: 24px 32px; border-bottom: 1px solid #e0e0e0; display: flex; align-items: center; }
                    .logo-box { width: 32px; height: 32px; background: #1a1a1a; border-radius: 4px; display: inline-flex; align-items: center; justify-content: center; }
                    .logo-box span { color: #ffffff; font-size: 13px; font-weight: 600; }
                    .brand { margin-left: 10px; }
                    .brand-name { font-size: 14px; font-weight: 600; color: #1a1a1a; margin: 0; }
                    .brand-sub { font-size: 11px; color: #888888; margin: 0; letter-spacing: 0.3px; }
                    .body { padding: 36px 32px; }
                    .label { font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; color: #888888; margin: 0 0 14px; }
                    .body h2 { font-size: 19px; font-weight: 600; color: #1a1a1a; margin: 0 0 12px; }
                    .body p { font-size: 14px; line-height: 1.7; color: #555555; margin: 0 0 16px; }
                    .info-box { background: #f9f9f9; border: 1px solid #e8e8e8; border-radius: 4px; padding: 16px 20px; margin: 20px 0; }
                    .info-row { display: flex; justify-content: space-between; font-size: 13px; margin-bottom: 8px; }
                    .info-row:last-child { margin-bottom: 0; }
                    .info-label { color: #888888; }
                    .info-value { color: #1a1a1a; font-weight: 500; }
                    .badge { display: inline-block; background: #f0fdf4; color: #15803d; font-size: 11px; font-weight: 600; padding: 3px 10px; border-radius: 999px; letter-spacing: 0.3px; }
                    .btn { display: inline-block; margin-top: 24px; padding: 11px 24px; background: #1a1a1a; color: #ffffff; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: 500; }
                    .divider { border: none; border-top: 1px solid #e8e8e8; margin: 24px 0; }
                    .note { font-size: 12px; color: #aaaaaa; line-height: 1.6; }
                    .footer { padding: 18px 32px; border-top: 1px solid #e0e0e0; display: flex; justify-content: space-between; }
                    .footer p { font-size: 11px; color: #aaaaaa; margin: 0; }
                </style>
            </head>
            <body>
                <div class="wrap">
                    <div class="header">
                        <div class="logo-box"><span>N</span></div>
                        <div class="brand">
                            <p class="brand-name">NEO-HUB</p>
                            <p class="brand-sub">IoT Equipment &amp; Project Marketplace</p>
                        </div>
                    </div>
                    <div class="body">
                        %s
                    </div>
                    <div class="footer">
                        <p>&copy; 2025 NEO-HUB. All rights reserved.</p>
                        <p>Automated email — do not reply</p>
                    </div>
                </div>
            </body>
            </html>
        """.formatted(content);
    }


    public static String verificationEmail(String name, String verifyLink) {
        String content = """
            <p class="label">Email Verification</p>
            <h2>Verify your email address</h2>
            <p>Hi %s, thank you for creating a NEO-HUB account. Please confirm your email address by clicking the button below.</p>
            <p>This link will expire in <strong>24 hours</strong>.</p>
            <a href="%s" class="btn">Verify Email</a>
            <hr class="divider"/>
            <p class="note">If you did not create an account, you can safely ignore this email.</p>
        """.formatted(name, verifyLink);
        return baseTemplate(content);
    }

    public static String orderConfirmationEmail(String name, String orderId, String total) {
        String content = """
            <p class="label">Order Confirmed</p>
            <h2>Your order has been placed</h2>
            <p>Hi %s, we've received your order and it's being processed. You'll get another email once it's shipped.</p>
            <div class="info-box">
                <div class="info-row"><span class="info-label">Order ID</span><span class="info-value">#%s</span></div>
                <div class="info-row"><span class="info-label">Total Amount</span><span class="info-value">Rs. %s</span></div>
                <div class="info-row"><span class="info-label">Payment Status</span><span class="badge">Received</span></div>
            </div>
            <p>You can view and track your order from the Order History section of your account.</p>
            <a href="http://localhost:8080/NEO-HUB/orders" class="btn">Track Order</a>
        """.formatted(name, orderId, total);
        return baseTemplate(content);
    }

    public static String passwordResetEmail(String name, String resetLink) {
        String content = """
            <p class="label">Password Reset</p>
            <h2>Reset your password</h2>
            <p>Hi %s, we received a request to reset your NEO-HUB account password. Click the button below to proceed.</p>
            <p>This link will expire in <strong>1 hour</strong>.</p>
            <a href="%s" class="btn">Reset Password</a>
            <hr class="divider"/>
            <p class="note">If you did not request a password reset, you can safely ignore this email. Your password will not change.</p>
        """.formatted(name, resetLink);
        return baseTemplate(content);
    }
}
