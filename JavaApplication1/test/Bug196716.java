import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLClassLoader;
import java.net.URLConnection;
import java.util.zip.CRC32;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
public class Bug196716 {
    public static void main(String[] args) throws Exception {
        URLConnection conn = Bug196716.class.getResource("Bug196716.class").openConnection();
        int len = conn.getContentLength();
        byte[] data = new byte[len];
        InputStream is = conn.getInputStream();
        is.read(data);
        is.close();
        conn.setDefaultUseCaches(false);
        File jar = File.createTempFile("Bug196716", ".jar");
        jar.deleteOnExit();
        OutputStream os = new FileOutputStream(jar);
        ZipOutputStream zos = new ZipOutputStream(os);
        ZipEntry ze = new ZipEntry("Bug196716.class");
        ze.setMethod(ZipEntry.STORED);
        ze.setSize(len);
        CRC32 crc = new CRC32();
        crc.update(data);
        ze.setCrc(crc.getValue());
        zos.putNextEntry(ze);
        zos.write(data, 0, len);
        zos.closeEntry();
        zos.finish();
        zos.close();
        os.close();
        System.out.println(new URLClassLoader(new URL[] {new URL("jar:" + jar.toURI() + "!/")}, ClassLoader.getSystemClassLoader().getParent()).loadClass(Bug196716.class.getName()));
    }
    private Bug196716() {}
}
