﻿// <auto-generated />
using System;
using BaoDuongXeMay.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace BaoDuongXeMay.Migrations
{
    [DbContext(typeof(MyDbContext))]
    partial class MyDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.10")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("BaoDuongXeMay.Data.Accessary", b =>
                {
                    b.Property<Guid>("AccessaryID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("AccessaryName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Image")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("AccessaryID");

                    b.ToTable("Accessaries");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.CategoryVehicle", b =>
                {
                    b.Property<Guid>("CategoryVehicleID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("CategoryVehicleName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Image")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("CategoryVehicleID");

                    b.ToTable("CategoryVehicles");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetailVehicle_User", b =>
                {
                    b.Property<Guid>("IDDeatil")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<float>("KM_Current")
                        .HasColumnType("real");

                    b.Property<float>("KM_Old")
                        .HasColumnType("real");

                    b.Property<int>("UserID")
                        .HasColumnType("int");

                    b.Property<Guid>("VehicleID")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("IDDeatil");

                    b.HasIndex("UserID");

                    b.HasIndex("VehicleID");

                    b.ToTable("DetailVehicle_User");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetaillNAU", b =>
                {
                    b.Property<Guid>("IDDetailNAU")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("AccessaryID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("CountPerforation")
                        .HasColumnType("int");

                    b.Property<int>("Km_Max")
                        .HasColumnType("int");

                    b.Property<int>("Km_Min")
                        .HasColumnType("int");

                    b.Property<Guid>("UnitID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("VehicleID")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("IDDetailNAU");

                    b.HasIndex("AccessaryID");

                    b.HasIndex("UnitID");

                    b.HasIndex("VehicleID");

                    b.ToTable("DetailNAU");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.History", b =>
                {
                    b.Property<Guid>("IdHistory")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("IDDeatil")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("IDDetailNAU")
                        .HasColumnType("uniqueidentifier");

                    b.Property<float>("Km_accumulation")
                        .HasColumnType("real");

                    b.Property<DateTime>("RepairDate")
                        .HasColumnType("datetime2");

                    b.Property<float>("TotalCost")
                        .HasColumnType("real");

                    b.HasKey("IdHistory");

                    b.HasIndex("IDDeatil");

                    b.HasIndex("IDDetailNAU");

                    b.ToTable("History");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.RefreshToken", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("ExpiredAt")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsRevoked")
                        .HasColumnType("bit");

                    b.Property<bool>("IsUsed")
                        .HasColumnType("bit");

                    b.Property<DateTime>("IssuedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("JwtId")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Token")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("UserID")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UserID");

                    b.ToTable("RefreshToken");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Unit", b =>
                {
                    b.Property<Guid>("UnitID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("UnitName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UnitID");

                    b.ToTable("Units");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.User", b =>
                {
                    b.Property<int>("UserID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Image")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Password")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("UserID");

                    b.HasIndex("Username")
                        .IsUnique()
                        .HasFilter("[Username] IS NOT NULL");

                    b.ToTable("User");
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

                    b.Property<string>("Image")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VehicleName")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.HasKey("VehicleID");

                    b.HasIndex("CategoryVehicleID");

                    b.ToTable("Vehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetailVehicle_User", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.User", "User")
                        .WithMany("DetailVehicle_Users")
                        .HasForeignKey("UserID")
                        .HasConstraintName("FK_User_DetailVehicleUser")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("BaoDuongXeMay.Data.Vehicle", "Vehicle")
                        .WithMany("DetailVehicle_Users")
                        .HasForeignKey("VehicleID")
                        .HasConstraintName("FK_Vehicle_DetailVehicleUser")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");

                    b.Navigation("Vehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetaillNAU", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.Accessary", "Accessary")
                        .WithMany("DetailNaus")
                        .HasForeignKey("AccessaryID")
                        .HasConstraintName("FK_Accessary_DetailNaus")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("BaoDuongXeMay.Data.Unit", "Unit")
                        .WithMany("DetailNaus")
                        .HasForeignKey("UnitID")
                        .HasConstraintName("FK_Unit_DetailNaus")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("BaoDuongXeMay.Data.Vehicle", "Vehicle")
                        .WithMany("DetailNaus")
                        .HasForeignKey("VehicleID")
                        .HasConstraintName("FK_Vehicle_DetailNaus")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Accessary");

                    b.Navigation("Unit");

                    b.Navigation("Vehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.History", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.DetailVehicle_User", "DetailVehicle_User")
                        .WithMany("Histories")
                        .HasForeignKey("IDDeatil")
                        .HasConstraintName("FK_DetailVehicleUser_Histories")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("BaoDuongXeMay.Data.DetaillNAU", "DetaillNAU")
                        .WithMany("Histories")
                        .HasForeignKey("IDDetailNAU")
                        .HasConstraintName("FK_DetaillNAU_Histories")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("DetaillNAU");

                    b.Navigation("DetailVehicle_User");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.RefreshToken", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.User", "User")
                        .WithMany()
                        .HasForeignKey("UserID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.HasOne("BaoDuongXeMay.Data.CategoryVehicle", "CategoryVehicle")
                        .WithMany("Vehicles")
                        .HasForeignKey("CategoryVehicleID");

                    b.Navigation("CategoryVehicle");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Accessary", b =>
                {
                    b.Navigation("DetailNaus");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.CategoryVehicle", b =>
                {
                    b.Navigation("Vehicles");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetailVehicle_User", b =>
                {
                    b.Navigation("Histories");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.DetaillNAU", b =>
                {
                    b.Navigation("Histories");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Unit", b =>
                {
                    b.Navigation("DetailNaus");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.User", b =>
                {
                    b.Navigation("DetailVehicle_Users");
                });

            modelBuilder.Entity("BaoDuongXeMay.Data.Vehicle", b =>
                {
                    b.Navigation("DetailNaus");

                    b.Navigation("DetailVehicle_Users");
                });
#pragma warning restore 612, 618
        }
    }
}
