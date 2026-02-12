package gym_backend.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import gym_backend.service.LogService;

@RestController
public class LogController {
    // Atributos
    LogService logS;

    // Construtor (recebe a instância do logService)
    public LogController(LogService logS) {
        this.logS = logS;
    }

    // Métodos
    @GetMapping("/printlog")
    public List<String> printLog() {
        return logS.getLog();
    }
}
