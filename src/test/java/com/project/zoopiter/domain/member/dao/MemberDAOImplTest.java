package com.project.zoopiter.domain.member.dao;

import com.project.zoopiter.domain.entity.Member;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MemberDAOImplTest {

  @Autowired
  private MemberDAO memberDAO;

  @Test
  @DisplayName("가입")
  void save(){
    Member member = new Member();
    member.setUserId("test1");
    member.setUserPw("test1111");
    member.setUserEmail("test1@gmail.com");
    member.setUserNick("회원1");
    member.setGubun("M0101");

    Member savedMember = memberDAO.save(member);

    Assertions.assertThat(savedMember.getUserId()).isEqualTo("test1");
    Assertions.assertThat(savedMember.getUserPw()).isEqualTo("test1111");
    Assertions.assertThat(savedMember.getUserEmail()).isEqualTo("test1@gmail.com");
    Assertions.assertThat(savedMember.getUserNick()).isEqualTo("회원1");
    Assertions.assertThat(savedMember.getGubun()).isEqualTo("M0101");


  }
}
