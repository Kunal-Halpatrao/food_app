<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Food You Like App</title>
    <style>
        body {
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 100px;
            width: 500px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0,0,0,0.2);
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        input[type="text"] {
            width: 90%;
            padding: 10px;
            font-size: 18px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
        label {
            font-size: 20px;
            color: #555;
        }
        .radio-group {
            margin: 20px 0;
        }
        input[type="radio"] {
            margin: 10px;
            transform: scale(1.3);
        }
        input[type="submit"] {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 20px;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
        }
        input[type="submit"]:hover {
            background: #45a049;
        }
        .message {
            margin-top: 25px;
            padding: 15px;
            border-radius: 10px;
            font-size: 18px;
            text-align: center;
            line-height: 1.5em;
        }
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
    <script>
        function check() {
            let iname = document.getElementById("iname");
            if (iname.value.trim() === "") {
                alert("Name cannot be empty!");
                iname.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <center>
        <div class="container">
            <h1>🍴 Food You Like App 🍴</h1>
            <form onsubmit="return check()" method="POST">
                <input type="text" name="name" placeholder="Enter your name" id="iname" />
                <br/>
                <label>Select One You Like</label>
                <div class="radio-group">
                    <input type="radio" name="f" value="North Indian"/> North Indian
                    <input type="radio" name="f" value="South Indian" checked/> South Indian
                    <input type="radio" name="f" value="Fast Food"/> Fast Food
                </div>
                <input type="submit" name="btn" value="Submit"/>
            </form>

            <%
                if(request.getParameter("btn") != null) {
                    String name = request.getParameter("name");
                    String choice = request.getParameter("f");

                    String msg = "";
                    String msgClass = "";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/food26dec24";
                        String user = "root";
                        String pass = "Krishna";

                        try(Connection con = DriverManager.getConnection(url, user, pass)) {
                            String sql = "INSERT INTO person VALUES(?, ?)";
                            try(PreparedStatement pst = con.prepareStatement(sql)) {
                                pst.setString(1, name);
                                pst.setString(2, choice);
                                pst.executeUpdate();
                                msg = "✅ Thank you, <b>" + name + "</b>!<br>Your choice (<b>" + choice + "</b>) has been saved.";
                                msgClass = "success";
                            }
                        }
                    } catch(Exception e) {
                        msg = "❌ Error: " + e.getMessage();
                        msgClass = "error";
                    }
            %>
                <div class="message <%= msgClass %>"><%= msg %></div>
            <%
                }
            %>
        </div>
    </center>
</body>
</html>
