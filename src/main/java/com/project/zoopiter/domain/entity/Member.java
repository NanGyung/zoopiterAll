package com.project.zoopiter.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
  private String userId;
  private String userPw;
  private String userEmail;
  private String userNick;
  private String gubun;
  private byte[] userPhoto;

  public Member(String userId, String userPw, String userEmail) {
    this.userId = userId;
    this.userPw = userPw;
    this.userEmail = userEmail;
  }
}
