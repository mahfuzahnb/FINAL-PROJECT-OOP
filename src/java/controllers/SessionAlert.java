package controllers;

import javax.servlet.http.HttpSession;
import models.Notificationable;

public class SessionAlert implements Notificationable {
    private HttpSession session;

    public SessionAlert(HttpSession session) {
        this.session = session;
    }

    @Override
    public void setMessage(String type, String message) {
        session.setAttribute("alertMessage", message);
        session.setAttribute("alertType", type.equalsIgnoreCase("success") ? "alert-success" : "alert-danger");
    }

    @Override
    public String getMessage() {
        String message = (String) session.getAttribute("alertMessage");
        session.removeAttribute("alertMessage");
        return message;
    }

    @Override
    public String getMessageType() {
        String type = (String) session.getAttribute("alertType");
        session.removeAttribute("alertType");
        return type;
    }
}
