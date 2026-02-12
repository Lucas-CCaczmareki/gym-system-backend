package gym_backend.dto;

import java.util.List;

import gym_backend.enums.ExerciseCategory;
import gym_backend.enums.ExerciseType;
import lombok.Data;

@Data
public class ExerciseDTO {

    private String baseExercise;        // "supino reto"
    private ExerciseType type;          // "Barra livre", "Máquina", "Barra guiada", "Halter"...
    private ExerciseCategory category;  // multiarticular ou isolador
    
    // Esse expected range pode até virar um outro objeto no futuro
    // pra eu conseguir comparar com o resultado dos sets. Mas fica provisoriamente assim
    private String expectedRange;       // "4x8-10 rir2-1"
    private List<SetDTO> sets;          // set1, set2, set3 (topset), set4(backset)

}
