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
        public DbSet<Accessary> Accessaries { get; set; }
        public DbSet<DetaillNAU> DetaillNAUs { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DetaillNAU>(entity =>
            {
                entity.ToTable("DetailNAU");
                entity.HasKey(e => new { e.AccessaryID, e.UnitID, e.VehicleID });

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
