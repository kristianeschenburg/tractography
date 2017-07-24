/**
 * Created by kristianeschenburg on 7/19/17.
 */

import java.io.*;
import java.io.IOException;
import java.util.*;
import com.google.gson.*;
import java.lang.*;
import niftijio.*;

public class voxelMaps {

    public static void main(String[] args) throws IOException {

        String inCoordinates = args[0];
        String labelFile = args[1];
        String mapFile = args[2];
        String outJson = args[3];

        voxelMapper vm = new voxelMapper(inCoordinates,labelFile,mapFile);
        HashMap<Integer,ArrayList<Integer>> map = vm.labelToCoordinateMaps();

        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(map);

        PrintWriter out = new PrintWriter(outJson);
        out.println(json);
        out.close();

    }
}
