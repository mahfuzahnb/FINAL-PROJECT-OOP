/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package models;

/**
 *
 * @author Asus
 */
public interface Notificationable {
    void setMessage(String type, String message);
    String getMessageType();
    String getMessage();
}

