package com.project.zoopiter.web;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginMember {
  private String userId;
  private String userEmail;
  private String userNick;
  private String gubun;
}
