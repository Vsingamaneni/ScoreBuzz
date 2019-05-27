package com.sports.cricket.util;

import com.sports.cricket.constants.Choice;
import com.sports.cricket.model.Register;

public class RegisterUserUtil {

    public static void setChoice(Register register){
        if (null != register.getChoice()){
            if (register.getChoice().equalsIgnoreCase(Choice.ODDS_PER_GAME)){
                register.setChoice("1");
            } else if (register.getChoice().equalsIgnoreCase(Choice.TOP_TEN)){
                register.setChoice("2");
            } else {
                register.setChoice("3");
            }
        }
    }
}
