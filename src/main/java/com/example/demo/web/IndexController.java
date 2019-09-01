package com.example.demo.web;

import com.example.demo.entity.User;
import com.example.demo.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * <p></p>
 *
 * @author jiuhua.xu
 * @version 1.0
 * @since JDK 1.8
 */
@Controller
public class IndexController {

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Autowired
    private UserMapper userMapper;

    @RequestMapping("redis")
    public String redis(Model model) {
        redisTemplate.opsForValue().set("hello", "Docker");
        String hello = redisTemplate.opsForValue().get("hello");
        model.addAttribute("hello", "Hello, " + hello);
        return "index";
    }

    @GetMapping("db")
    public ResponseEntity db() {
        List<User> userList = userMapper.selectList(null);
        return ResponseEntity.ok(userList);
    }

}
