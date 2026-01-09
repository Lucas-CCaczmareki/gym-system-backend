package gym_backend.dto;

import java.util.List;

public class ExerciseDTO {

    private String name;            // "supino reto com barra"
    private String expectedRange;   // "4x8-10 rir2-1"
    private List<SetsDTO> sets;     // set1, set2, set3 (topset), set4(backset)

}
