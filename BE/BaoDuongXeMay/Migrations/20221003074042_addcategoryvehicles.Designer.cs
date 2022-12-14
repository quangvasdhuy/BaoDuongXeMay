// <auto-generated />
using System;
using BaoDuongXeMay.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace BaoDuongXeMay.Migrations
{
    [DbContext(typeof(MyDbContext))]
    [Migration("20221003074042_addcategoryvehicles")]
    partial class addcategoryvehicles
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.10")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("BaoDuongXeMay.Data.CategoryVehicle", b =>
                {
                    b.Property<Guid>("CategoryVehicleID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("CategoryVehicleName")
                        .HasColumnType("int");

                    b.HasKey("CategoryVehicleID");

                    b.ToTable("CategoryVehicles");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.Property<Guid>("VehicleID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("CategoryVehicleID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VehicleName")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.HasKey("VehicleID");

                    b.HasIndex("CategoryVehicleID");

                    b.ToTable("Vehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.CategoryVehicle", "CategoryVehicle")
                        .WithMany("Vehicles")
                        .HasForeignKey("CategoryVehicleID");

                    b.Navigation("CategoryVehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.CategoryVehicle", b =>
                {
                    b.Navigation("Vehicles");
                });
#pragma warning restore 612, 618
        }
    }
}
