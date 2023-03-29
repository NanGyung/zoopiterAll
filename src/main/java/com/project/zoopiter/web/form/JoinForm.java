package com.project.zoopiter.web.form;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class JoinForm {

  @NotBlank
  @Size(min = 5, max = 20)
  private String userId;

  @NotBlank
  @Size(min = 8, max = 15)
  private String userPw;

  private String userPwChk;

  @Email
  @NotBlank
  private String userEmail;

  private String userNick;
  private String gubun;

}
