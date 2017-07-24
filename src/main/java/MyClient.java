import java.io.*;
import java.lang.*;
import java.io.Writer;
import java.util.*;
import com.google.gson.*;
/**
 * Created by kristianeschenburg on 7/19/17.
 */

public class MyClient {

    public static String inDir =
            "/Users/kristianeschenburg/Documents/GitHub/tractography/src/main/java/";

     static final String inLookUp = inDir + "tract_space_coords_for_fdt_matrix2.txt";
    public static final String inLabel = inDir + "Left.ROIS.acpc_dc.1.25.nii.gz";
    public static final String inMap = inDir + "lookup_tractspace_fdt_matrix2.nii.gz";

    public static void main(String[] args) throws IOException {

        voxelMapper vm = new voxelMapper(inLookUp, inLabel, inMap);

        HashMap<Integer, ArrayList<Integer>> map = vm.labelToCoordinateMaps();

        String outFile = "/Users/kristianeschenburg/Desktop/TestJson.txt";
        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(map);

        PrintWriter out = new PrintWriter(outFile);
        out.println(json);
        out.close();
    }
}
