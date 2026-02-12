package gym_backend.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

// Service = uma única instância criada pelo Spring para toda a aplicação.
@Service
public class LogService {
    // Atributo
    private final List<String> log = new ArrayList<>();

    // Métodos
    public void addLog(String message) {
        log.add(message);
    }

    public List<String> getLog() {
        return log;
    }

    // public void printLog() {
    //     for(String message : log) {
    //         System.out.println(message);
    //     }
    // }
}
