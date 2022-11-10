using Microsoft.EntityFrameworkCore;

namespace BaoDuongXeMay.Data
{
    public class MyDbContext :DbContext
    {
        public MyDbContext(DbContextOptions options) : base(options) { }

        #region DbSet
        public DbSet<Vehicle> Vehicles { get; set; }
        public DbSet<CategoryVehicle> CategoryVehicles { get; set; }
        public DbSet<Unit> Units { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<RefreshToken> RefreshTokens { get; set; }

        public DbSet<Accessary> Accessaries { get; set; }
        public DbSet<DetaillNAU> DetaillNAUs { get; set; }
        public DbSet<DetailVehicle_User> DetailVehicle_Users { get; set; }
        public DbSet<History> Histories { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DetaillNAU>(entity =>
            {
                entity.ToTable("DetailNAU");
                entity.HasKey(e => new { e.IDDetailNAU });

                entity.HasOne(e => e.Accessary)
                    .WithMany(e => e.DetailNaus)
                    .HasForeignKey(e => e.AccessaryID)
                    .HasConstraintName("FK_Accessary_DetailNaus");

                entity.HasOne(e => e.Unit)
                   .WithMany(e => e.DetailNaus)
                   .HasForeignKey(e => e.UnitID)
                   .HasConstraintName("FK_Unit_DetailNaus");

                entity.HasOne(e => e.Vehicle)
                   .WithMany(e => e.DetailNaus)
                   .HasForeignKey(e => e.VehicleID)
                   .HasConstraintName("FK_Vehicle_DetailNaus");
            });

            modelBuilder.Entity<DetailVehicle_User>(entity =>
            {
                entity.ToTable("DetailVehicle_User");
                entity.HasKey(e => new { e.IDDeatil });

                entity.HasOne(e => e.User)
                    .WithMany(e => e.DetailVehicle_Users)
                    .HasForeignKey(e => e.UserID)
                    .HasConstraintName("FK_User_DetailVehicleUser");

                entity.HasOne(e => e.Vehicle)
                   .WithMany(e => e.DetailVehicle_Users)
                   .HasForeignKey(e => e.VehicleID)
                   .HasConstraintName("FK_Vehicle_DetailVehicleUser");
                   
            });


            modelBuilder.Entity<History>(entity =>
            {
                entity.ToTable("History");
                entity.HasKey(e => new { e.IdHistory });

                entity.HasOne(e => e.DetaillNAU)
                    .WithMany(e => e.Histories)
                    .HasForeignKey(e => e.IDDetailNAU)
                    .HasConstraintName("FK_DetaillNAU_Histories");

                entity.HasOne(e => e.DetailVehicle_User)
                   .WithMany(e => e.Histories)
                   .HasForeignKey(e => e.IDDeatil)
                   .HasConstraintName("FK_DetailVehicleUser_Histories");

            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasIndex(e => e.Username).IsUnique();
                entity.Property(e => e.Name).IsRequired();
                entity.Property(e => e.Email).IsRequired();

            });
        }
        #endregion
    }
}
