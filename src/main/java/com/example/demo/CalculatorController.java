package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class CalculatorController {

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @PostMapping("/calculate")
    public String calculate(@RequestParam int a,
                            @RequestParam int b,
                            @RequestParam String op,
                            Model model) {

        int result = switch (op) {
            case "add" -> a + b;
            case "sub" -> a - b;
            case "mul" -> a * b;
            case "div" -> b != 0 ? a / b : 0;
            default -> 0;
        };

        model.addAttribute("result", result);
        return "index";
    }
}