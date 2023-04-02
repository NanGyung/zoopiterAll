package com.project.zoopiter.web.form;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class LoginForm {
  @NotBlank
  private String userId;
  @NotBlank
  private String userPw;
}
