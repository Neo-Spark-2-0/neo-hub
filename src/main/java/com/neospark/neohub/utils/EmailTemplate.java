package com.neospark.neohub.utils;


public class EmailTemplate {

    private static String baseTemplate(String content) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8"/>
                <style>
                    body        { font-family: 'Segoe UI', sans-serif; background: #f3f4f6; margin:0; padding:0; }
                    .container  { max-width: 600px; margin: 40px auto; background: #fff;
                                  border-radius: 12px; overflow: hidden;
                                  box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
                    .header     { background: #3B82F6; padding: 30px; text-align: center; }
                    .header h1  { color: #fff; margin: 0; font-size: 28px; letter-spacing: 1px; }
                    .header p   { color: #bfdbfe; margin: 5px 0 0; font-size: 13px; }
                    .body       { padding: 40px 30px; color: #374151; }
                    .body h2    { font-size: 20px; margin-bottom: 10px; }
                    .body p     { font-size: 14px; line-height: 1.6; color: #6b7280; }
                    .btn        { display: inline-block; margin: 20px 0; padding: 12px 32px;
                                  background: #3B82F6; color: #fff; text-decoration: none;
                                  border-radius: 8px; font-weight: 600; font-size: 14px; }
                    .btn:hover  { background: #2563eb; }
                    .footer     { background: #f9fafb; padding: 20px; text-align: center;
                                  font-size: 12px; color: #9ca3af; border-top: 1px solid #e5e7eb; }
                    .divider    { border: none; border-top: 1px solid #e5e7eb; margin: 20px 0; }
                    .badge      { display: inline-block; background: #ecfdf5; color: #10b981;
                                  padding: 4px 12px; border-radius: 999px; font-size: 12px;
                                  font-weight: 600; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>NEO-HUB</h1>
                        <p>IoT Equipment & Project Marketplace</p>
                    </div>
                    <div class="body">
                        %s
                    </div>
                    <div class="footer">
                        &copy; 2025 NEO-HUB. All rights reserved.<br/>
                        This is an automated email — please do not reply.
                    </div>
                </div>
            </body>
            </html>
        """.formatted(content);
    }


    public static String verificationEmail(String name, String verifyLink) {
        String content = """
            <h2>Hello, %s! 👋</h2>
            <p>Thank you for registering at <strong>NEO-HUB</strong>.</p>
            <p>Please verify your email address by clicking the button below.
               This link expires in <strong>24 hours</strong>.</p>
            <a href="%s" class="btn">✅ Verify Email</a>
            <hr class="divider"/>
            <p>If you didn't create an account, you can safely ignore this email.</p>
        """.formatted(name, verifyLink);
        return baseTemplate(content);
    }

    public static String orderConfirmationEmail(String name, String orderId, String total) {
        String content = """
            <h2>Order Confirmed! 🎉</h2>
            <p>Hi <strong>%s</strong>, your order has been placed successfully.</p>
            <p>
                <strong>Order ID:</strong> #%s<br/>
                <strong>Total Amount:</strong> Rs. %s
            </p>
            <span class="badge">✅ Payment Received</span>
            <hr class="divider"/>
            <p>We'll notify you once your order is shipped. 
               You can track your order in the <strong>Order History</strong> section.</p>
            <a href="http://localhost:8080/NEO-HUB/orders" class="btn">Track Order</a>
        """.formatted(name, orderId, total);
        return baseTemplate(content);
    }

    public static String passwordResetEmail(String name, String resetLink) {
        String content = """
            <h2>Password Reset Request 🔐</h2>
            <p>Hi <strong>%s</strong>, we received a request to reset your password.</p>
            <p>Click the button below to reset it. This link expires in <strong>1 hour</strong>.</p>
            <a href="%s" class="btn">Reset Password</a>
            <hr class="divider"/>
            <p>If you didn't request a password reset, ignore this email.</p>
        """.formatted(name, resetLink);
        return baseTemplate(content);
    }
}
