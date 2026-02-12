package gym_backend.dto;

import java.time.LocalDate;
import java.util.List;
import lombok.Data;

@Data // isso usa a biblioteca "lombok" pra criar automaticamente todos getters e setters dos atributos
public class WorkoutDTO {
    private String name;
    private String day;
    private LocalDate date;
    private List<ExerciseDTO> exercises;
}
