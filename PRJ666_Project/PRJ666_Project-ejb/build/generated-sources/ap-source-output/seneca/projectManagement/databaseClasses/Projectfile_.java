package seneca.projectManagement.databaseClasses;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.databaseClasses.Projects;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-24T22:34:46")
@StaticMetamodel(Projectfile.class)
public class Projectfile_ { 

    public static volatile SingularAttribute<Projectfile, String> filename;
    public static volatile SingularAttribute<Projectfile, String> filedescription;
    public static volatile SingularAttribute<Projectfile, String> thefile;
    public static volatile SingularAttribute<Projectfile, Projects> projectid;
    public static volatile SingularAttribute<Projectfile, Integer> fileid;

}