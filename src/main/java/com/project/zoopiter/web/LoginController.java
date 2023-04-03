package com.project.zoopiter.web;

import com.project.zoopiter.domain.member.svc.MemberSVC;
import com.project.zoopiter.web.form.LoginForm;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Slf4j
@Controller
@RequiredArgsConstructor
public class LoginController {
  private final MemberSVC memberSVC;

  //로그인화면
  @GetMapping("/login")
  public String loginForm(Model model){
    model.addAttribute("loginForm", new LoginForm());
    return "member/member_login";
  }

}
