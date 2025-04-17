package com.suihin.ews.domain;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class AccountController {

    @GetMapping("/")
    public ModelAndView index() {
        return new ModelAndView("pages/index");
    }

    @GetMapping("/sign-up")
    public ModelAndView signUp() {
        return new ModelAndView("pages/user/signup");
    }

    @GetMapping("/find-account")
    public ModelAndView findAccount() {
        return new ModelAndView("pages/user/find_account");
    }
}